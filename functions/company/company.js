const functions = require("firebase-functions");

// user deleted
exports.userDeleted = async function(document, context, admin){

    let user = document.data();

    const db = admin.firestore();

    console.log('User company:', user.companyId);

    const companyMembers = await db 
      .collection('users')
      .where('companyId', '==', user.companyId)
      .get();
      
    const users = companyMembers.docs;

    if (users.length === 0) {
      console.log('No more users - delete company');
      await db
        .collection('companies')
        .doc(user.companyId)
        .delete();
    } else {
      console.log('Contains users - DONT DELETE');    
    }

    return;
}