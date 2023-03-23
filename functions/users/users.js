const functions = require("firebase-functions");

// new user handler
exports.added = async function(change, context, admin){
  let userId = context.params.userId;

  const db = admin.firestore();

  // updated user
  const oldUser = change.before.data();

  // updated user
  const newUser = change.after.data();

  if(oldUser.companyId == "" && newUser.companyId != ""){

    // notification data
    const text = newUser.firstName + " " + newUser.lastName;
    const payload = {
      notification: {
        title_loc_key: 'new_user',
        body: text,
        sound: 'default',
      },
      data:{
        type: 'newUser',
        id: userId,
      }
    };
    const dbPayload = {
      'type': 'newUser',
      'code': 'NEW',
      'connectedId': userId,
      'read': false,
      'date': Date.now(),
    };

    const tokens = [];
    const userIds = [];

    var users = [];

    // get administrators
    const groupUsers = await db
      .collection('users')
      .where('companyId', '==', newUser.companyId)
      .where('administrator', '==', true)
      .get();
        
    users = groupUsers.docs;

    if (users.empty) {
      console.log('No matching documents.');
      return;
    }

    for(const user of users){
      // users devices
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

    // add new in app notifications to the db
    for(const adminId of userIds){
      await db
        .collection('users')
        .doc(adminId)
        .collection('notifications')
        .doc(userId)
        .set(dbPayload);
    }

    // send notifications
    if(tokens.length > 0){
      await admin.messaging().sendToDevice(tokens, payload);
    }
  }

  return;
}