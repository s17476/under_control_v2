const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();


exports.taskAdded = functions.firestore
    .document("companies/{companyId}/tasks/{taskId}")
    .onCreate(async (document, context) => {
      let companyId = context.params.companyId;

      const newTask = document.data();

      let tokens = [];
      
      // if task is assigned to a group
      if(newTask.assignedGroups.length != 0){
        const users = await db
          .collection('users')
          .where('companyId', '==', companyId)
          .where('userGroups', 'array-contains-any', newTask.assignedGroups)

          .get();

          if (users.empty) {
            console.log('No matching documents.');
            return;
          }

        users.forEach(async element => {
          const taskUser = await db
            .collection('users')
            .doc(element.id)
            .collection('settings')
            .doc('notifications')
            .get();

          console.log(taskUser.id, '=>', taskUser.data());
          
        });

        // for(let user in users){
        //   tokens = [...tokens, ...user.data.deviceTokens];
        // }

        //   console.log(tokens);
      }




      return;
    });
