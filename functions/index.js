const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.helloWorld = functions.database.ref('comaSystem/heartBeat').onUpdate(async evt => {
    const payload = {
        notification:{
            title : 'Motion Detected',
            body : 'Please check the patient, motion has been detected',
            badge : '1',
            sound : 'default'
        }
    };

    // const allToken = await admin.database().ref('fcm-token').once('value');
    // if (allToken.val() && evt.after.val() == 'yes') {
    //     console.log('token available');
    //     const token = Object.keys(allToken.val());
    //     return admin.messaging().sendToDevice("cCrMiTPwT5agT4cbjY2Cgu:APA91bFBVO3wOMcmrJ-Mz2Zk6neU1UlcVQ0g6F0rz5-VB7IXhTMRBtbj-zpG1w26TaXAXPCHvhF0CEYSSSz7XwfC1jiuiFaJxdm3sagtcMhhrGdRdFBSs9RDIu5k2XfG2YVZFt5EGXax", payload);
    // } else {
    //     console.log('No token available');
    // }

    // // const allToken = await admin.database().ref('fcm-token').once('value');
    // // if (allToken.val() && evt.after.val() == 'yes') {
    //     // console.log('token available');
    //     // const token = Object.keys(allToken.val());
    //     return admin.messaging().sendToDevice("cCrMiTPwT5agT4cbjY2Cgu:APA91bFBVO3wOMcmrJ-Mz2Zk6neU1UlcVQ0g6F0rz5-VB7IXhTMRBtbj-zpG1w26TaXAXPCHvhF0CEYSSSz7XwfC1jiuiFaJxdm3sagtcMhhrGdRdFBSs9RDIu5k2XfG2YVZFt5EGXax", payload);
    // // } else {
    // //     console.log('No token available');
    // // }




        return admin.messaging().sendToDevice("cy7STNXKTUiQqDViPE-INS:APA91bHpso3zJVfuDzwB-rohdgUqAnrah1HNvNp9U5QBx2iY7Lkj9QHADuNQ4xf10QNjvv1xsYqYgQCkWS3oHVtVtjj3HPmfphMPK50guqY1VOzw_s8OS6iXWB_ce8SpsrW1vdTxb7vC", payload);

});

