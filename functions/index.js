const functions = require("firebase-functions");
const admin = require("firebase-admin");

const task = require('./tasks/task');
const workRequest = require('./work_requests/work_request');

admin.initializeApp();
const db = admin.firestore();

// new task handler
exports.taskAdded = functions.firestore
  .document("companies/{companyId}/tasks/{taskId}")
  .onCreate((document, context) => task.added(document, context, admin));
// deleted task handler
exports.taskDeleted = functions.firestore
  .document("companies/{companyId}/tasks/{taskId}")
  .onDelete((document, context) => task.deleted(document, context, admin));

// new work request handler
exports.workRequestAdded = functions.firestore
  .document("companies/{companyId}/workRequests/{workRequestId}")
  .onCreate((document, context) => workRequest.added(document, context, admin));
// deleted work request
exports.workRequestDeleted = functions.firestore
  .document("companies/{companyId}/workRequests/{workRequestId}")
  .onDelete((document, context) => workRequest.deleted(document, context, admin));