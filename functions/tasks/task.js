const functions = require("firebase-functions");

// new task handler
exports.added = async function(document, context, admin) {

      let companyId = context.params.companyId;
      const newTask = document.data();
      const db = admin.firestore();

      // task execution date
      const executionDate = newTask.executionDate;
      const jsDate = executionDate.toDate();
      jsDate.setHours(0, 0, 0, 0);
      // now date
      const nowDate = new Date();
      nowDate.setHours(0, 0, 0, 0);
      // date difference
      var differenceInTime = jsDate.getTime() - nowDate.getTime();
      var differenceInDays = differenceInTime / (1000 * 3600 * 24);

      // don't send notification if date difference is bigger then 30 days
      if(differenceInDays > 29){
        console.log('Date difference bigger than 29 days. Difference: ', differenceInDays);
        return;
      }

      // notification data
      const text = newTask.title;
      const payload = {
        notification: {
          title_loc_key: 'new_task_title',
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
          sound: 'default',
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

      if (users.length === 0) {
        console.log('No matching documents.');
        return;
      }

      for(const user of users){
        if(document.data().userId != user.id){
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
            if(userTokens != undefined){
              userTokens.forEach(token => {
                if(tokens.indexOf(token) === -1){
                  tokens.push(token);
                }
              });
            }
            // users to get in app notification
            if(userIds.indexOf(user.id) === -1){
              userIds.push(user.id);
            }
          }
        }
      }
        
      // add new in app notifications to the db
      for(const userId of userIds){
        await db
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(document.id)
          .set(dbPayload);
      }

      // send notifications
      if(tokens.length > 0){
        await admin.messaging().sendToDevice(tokens, payload);
      }

      return;
    }

// task deleted handler - cancel or complete usecase
exports.deleted = async function(document, context, admin) {

      let companyId = context.params.companyId;

      const db = admin.firestore();

      const companyMembers = await db
        .collection('users')
        .where('companyId', '==', companyId)
        .get();
        
      const users = companyMembers.docs;

      if (users.length === 0) {
        console.log('No matching documents.');
        return;
      }

      for(const user of users){
        await db
          .collection('users')
          .doc(user.id)
          .collection('notifications')
          .doc(document.id)
          .delete();
      }
      return;
    }
