const functions = require("firebase-functions");
const admin = require("firebase-admin");

const task = require('./tasks/task');
const workRequest = require('./work_requests/work_request');
const item = require('./items/item');
const newUser = require('./users/users');

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

// item update handler
exports.itemUpdated = functions.firestore
  .document("companies/{companyId}/items/{itemId}")
  .onUpdate((change, context) => item.updated(change, context, admin));

// new user
exports.newUser = functions.firestore
  .document("users/{userId}")
  .onUpdate((change, context) => newUser.added(change, context, admin));