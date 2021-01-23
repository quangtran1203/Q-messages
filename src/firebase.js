// For Firebase JS SDK v7.20.0 and later, measurementId is optional
import firebase from "firebase";

const firebaseConfig = {
    apiKey: "AIzaSyClkRN6DfEWz6lAfwWxlImGyXDeCcZSz9A",
    authDomain: "qmessages-9de92.firebaseapp.com",
    projectId: "qmessages-9de92",
    storageBucket: "qmessages-9de92.appspot.com",
    messagingSenderId: "696855444127",
    appId: "1:696855444127:web:42add93e9d12da06b140aa",
    measurementId: "G-13KB9VSG17"
};
  
const firebaseApp = firebase.initializeApp(firebaseConfig);
const db = firebaseApp.firestore();
const auth = firebase.auth();
const provider = new firebase.auth.GoogleAuthProvider();

export { provider, auth };
export default db;