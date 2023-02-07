const functions = require("firebase-functions");

// item update handler - send notification if quantity is below limit
exports.updated = async function(change, context, admin) {

    let companyId = context.params.companyId;

    const db = admin.firestore();

    // updated item
    const newItem = change.after.data();

    const alertQuantity = newItem.alertQuantity;
    console.log('alertQuantity ', alertQuantity);

    // checks if alert quantity was set
    if(alertQuantity != undefined && alertQuantity != -1){
        const oldItem = change.before.data();
        
        // quantity before update
        var totalOldQuantity = 0;
        for(const quantityInLocation of oldItem.amountInLocations){
            totalOldQuantity = totalOldQuantity + quantityInLocation.amount;
        }
        // quantity after update
        var totalNewQuantity = 0;
        for(const quantityInLocation of newItem.amountInLocations){
            totalNewQuantity = totalNewQuantity + quantityInLocation.amount;
        }
        console.log('totalOldQuantity ', totalOldQuantity);
        console.log('totalNewQuantity ', totalNewQuantity);
        
        if(totalNewQuantity < totalOldQuantity && totalNewQuantity <= alertQuantity && totalOldQuantity > alertQuantity){
            console.log('sendNotification');


            // TODO:
            // add android and ios notification localizations
            // remove logs

            // notification data
            const text = newItem.producer + ' ' + newItem.name;
            const payload = {
                notification: {
                title_loc_key: 'item_below_limit',
                body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
                sound: 'default',
                },
                data:{
                type: 'items',
                id: change.after.id,
                }
            };
            const dbPayload = {
                'type': 'items',
                'code': 'UPDATE',
                'connectedId': change.after.id,
                'read': false,
                'date': Date.now(),
            };

            const tokens = [];
            const userIds = [];

            // gets all company members
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
                
                const userPermissions = await db
                    .collection('users')
                    .doc(user.id)
                    .collection('settings')
                    .doc('notifications')
                    .get();
        
                // check user permissions
                // if no permissions found, then default permission option is TRUE
                if((userPermissions.exists && (userPermissions.data().items == true || userPermissions.data().items == undefined)) || !userPermissions.exists){
                        
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

            // add new in app notifications to the db
            for(const userId of userIds){
                await db
                .collection('users')
                .doc(userId)
                .collection('notifications')
                .doc(change.after.id)
                .set(dbPayload);
            }

            // send notifications
            if(tokens.length > 0){
                await admin.messaging().sendToDevice(tokens, payload);
            }

        }else{
            console.log('No notification');
        }
    }
    return;
  }