const functions = require("firebase-functions");

// new work request handler
exports.added = async function(document, context, admin){
  
      let companyId = context.params.companyId;
      const newRequest = document.data();
      const db = admin.firestore();

      // notification data
      const text = newRequest.title;
      const payload = {
        notification: {
          title_loc_key: 'new_work_request_title',
          body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
          sound: 'default',
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
        'date': newRequest.date,
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

        if(newRequest.userId != user.id ){
          const userPermissions = await db
            .collection('users')
            .doc(user.id)
            .collection('settings')
            .doc('notifications')
            .get();

          // check user permissions
          // if no permissions found, then default permission option is TRUE
          if((userPermissions.exists && (userPermissions.data().workRequests == true || userPermissions.data().workRequests == undefined)) || !userPermissions.exists){
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

// work request deleted handler - cancel or convert usecase
exports.deleted = async function(document, context, admin){

      let companyId = context.params.companyId;

      const db = admin.firestore();

      const companyMembers = await db
        .collection('users')
        .where('companyId', '==', companyId)
        .get();
        
      const users = companyMembers.docs;

      if (users.empty) {
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
