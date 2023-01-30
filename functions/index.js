const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();


exports.taskAdded = functions.firestore
    .document("companies/{companyId}/tasks/{taskId}")
    .onCreate(async (document, context) => {
      let companyId = context.params.companyId;

      const newTask = document.data();

      // notification data
      const text = newTask.title;
      const payload = {
        notification: {
          title: `NEWTASK# ${document.id}`,
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
        }
      };
      const dbPayload = {
        'type': 'tasks',
        'groupTask': true,
        'title': 'NEWTASK#',
        'id': document.id,
      };

      const tokens = [];
      const userIds = [];
      
      // if task is assigned to a group
      if(newTask.assignedGroups.length != 0){
        // get users assigned to a group task
        const users = await db
          .collection('users')
          .where('companyId', '==', companyId)
          .where('userGroups', 'array-contains-any', newTask.assignedGroups)
          .get();

        if (users.empty) {
          console.log('No matching documents.');
          return;
        }

        
        // get notifications permissions for each user
        for(const user of users.docs){
          const userPermissions = await db
            .collection('users')
            .doc(user.id)
            .collection('settings')
            .doc('notifications')
            .get();

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
            
            // users collection
            if(userIds.indexOf(user.id) === -1){
              userIds.push(user.id);
            }
          }
        }

      }
      
      console.log('tokens =>',tokens);
      console.log('userIds =>',tokens);

      for(const token of tokens){
        console.log('sent notification to:', token);
      }
        
      // add new notifications to the db
      for(const userId of userIds){
        await addNotification(userId, document.id, dbPayload);

        console.log('Added to db');
      }
      await admin.messaging().sendToDevice(tokens, payload);

      return;
    });

function addNotification(userId, documentId, dbPayplad){
  return db
  .collection('users')
  .doc(userId)
  .collection('notifications')
  .doc(documentId)
  .set(dbPayplad);
}
