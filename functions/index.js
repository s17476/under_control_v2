const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

// new task handler
exports.taskAdded = functions.firestore
    .document("companies/{companyId}/tasks/{taskId}")
    .onCreate(async (document, context) => {

      let companyId = context.params.companyId;
      const newTask = document.data();

      // notification data
      const text = newTask.title;
      const payload = {
        notification: {
          title_loc_key: 'new_task_title',
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
        },
        data:{
          type: 'tasks',
          id: document.id,
        }
      };
      const dbPayload = {
        'type': 'tasks',
        'code': 'NEW',
        'connectedId': document.id,
        'read': false,
        'date': document.data().date,
      };

      const tokens = [];
      const userIds = [];

      var users = [];

      // if task is assigned to a group
      if(newTask.assignedGroups.length != 0){
        // get users assigned to a group task
        const groupUsers = await db
          .collection('users')
          .where('companyId', '==', companyId)
          .where('userGroups', 'array-contains-any', newTask.assignedGroups)
          .get();
        
          users = groupUsers.docs;
      }

      // if task is assigned to user(s)
      if(newTask.assignedUsers.length != 0){

        for(const assignedUser of newTask.assignedUsers){
          const usr = await db
          .collection('users')
          .doc(assignedUser)
          .get();

          users.push(usr);
        }
      }

      if (users.empty) {
        console.log('No matching documents.');
        return;
      }

      for(const user of users){
        if(document.data().userId != user.id){
          const userPermissions = await getNotificationSettings(user.id);

          // check user permissions
          // if no permissions found, then default permission option is TRUE
          if((userPermissions.exists && (userPermissions.data().tasks == true || userPermissions.data().tasks == undefined)) || !userPermissions.exists){
            // add token to the list
          
            const userTokens = user.data().deviceTokens;
            userTokens.forEach(token => {
              if(tokens.indexOf(token) === -1){
                tokens.push(token);
              }
            });
            // users to get in app notification
            if(userIds.indexOf(user.id) === -1){
              userIds.push(user.id);
            }
          }
        }
      }
        
      // add new in app notifications to the db
      for(const userId of userIds){
        await addNotificationToDb(userId, document.id, dbPayload);
      }

      // send notifications
      if(tokens.length > 0){
        await admin.messaging().sendToDevice(tokens, payload);
      }

      return;
    });

// new work request handler
exports.workRequestAdded = functions.firestore
    .document("companies/{companyId}/workRequests/{workRequestId}")
    .onCreate(async (document, context) => {

      let companyId = context.params.companyId;
      const newTask = document.data();

      // notification data
      const text = newTask.title;
      const payload = {
        notification: {
          title_loc_key: 'new_work_request_title',
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
        },
        data:{
          type: 'workRequests',
          id: document.id,
        }
      };
      const dbPayload = {
        'type': 'workRequests',
        'code': 'NEW',
        'connectedId': document.id,
        'read': false,
        'date': document.data().date,
      };

      const tokens = [];
      const userIds = [];

      var users = [];


      const requestUsers = await db
        .collection('users')
        .where('companyId', '==', companyId)
        .where('isActive', '==', true)
        .get();
        
      users = requestUsers.docs;
      

      if (users.empty) {
        console.log('No matching documents.');
        return;
      }

      for(const user of users){

        if(document.data().userId != user.id ){
          const userPermissions = await getNotificationSettings(user.id);

          // check user permissions
          // if no permissions found, then default permission option is TRUE
          if((userPermissions.exists && (userPermissions.data().workRequests == true || userPermissions.data().workRequests == undefined)) || !userPermissions.exists){
            // add token to the list
            const userTokens = user.data().deviceTokens;
            userTokens.forEach(token => {
              if(tokens.indexOf(token) === -1){
                tokens.push(token);
              }
            });
            // users to get in app notification
            if(userIds.indexOf(user.id) === -1){
              userIds.push(user.id);
            }
          }
        }
      }
        
      // add new in app notifications to the db
      for(const userId of userIds){
        await addNotificationToDb(userId, document.id, dbPayload);
      }

      // send notifications
      if(tokens.length > 0){
        await admin.messaging().sendToDevice(tokens, payload);
      }

      return;
    });

function addNotificationToDb(userId, documentId, dbPayplad){
  return db
  .collection('users')
  .doc(userId)
  .collection('notifications')
  .doc(documentId)
  .set(dbPayplad);
}

async function getNotificationSettings(userId){
  return db
  .collection('users')
  .doc(userId)
  .collection('settings')
  .doc('notifications')
  .get();
}
