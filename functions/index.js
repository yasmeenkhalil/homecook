const functions = require('firebase-functions');
const admin =require('firebase-admin');
admin.initialzeApp(functions.config().firebase);
var msgData;
exports.chatTrigger= functions.firestore.document('ChatRoom/{ChatRoomId}').onCreate((snapshot,context)=>{msgData=snapshot.data();

});

