// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';
import { getAuth } from 'firebase/auth';
import { getStorage } from 'firebase/storage';

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: 'AIzaSyBSWXMPrrbI0ywSOPRT1DOQgJC5i1YKmH8',
  authDomain: 'dolku-305e2.firebaseapp.com',
  projectId: 'dolku-305e2',
  storageBucket: 'dolku-305e2.appspot.com',
  messagingSenderId: '1053706147570',
  appId: '1:1053706147570:web:bcb947cad393499f66e26b',
  //   measurementId: 'G-1S42V399Q4',
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore();
const auth = getAuth(app);
const storage = getStorage(app);

export { app, db, auth, storage };
