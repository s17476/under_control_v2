const functions = require("firebase-functions");

exports.taskAdded = functions.firestore
    .document("companies/{companyId}/tasks/{taskId}")
    .onCreate((document, context) => {
      const newTask = document.data();
      console.log(newTask);

      return;
    });
