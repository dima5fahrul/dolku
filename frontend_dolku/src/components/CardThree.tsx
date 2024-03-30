import { useEffect, useState } from 'react';
import { onAuthStateChanged } from 'firebase/auth';
import { useNavigate } from 'react-router-dom';
import { db, auth } from './firebase/Config';
import { collection, doc, getDocs } from 'firebase/firestore';

const CardThree = () => {
  const Navigate = useNavigate();
  const [totalDocuments, setTotalDocuments] = useState(0);

  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        const uid = user.uid;
        const documentsCollection = collection(db, 'metadata');
        getDocs(documentsCollection)
          .then((querySnapshot) => {
            const total = querySnapshot.size;
            setTotalDocuments(total);
          })
          .catch((error) => {
            console.error('Error mengambil data koleksi:', error);
          });
      } else {
        // User is signed out
        Navigate('/signin');
        console.log('user is logged out');
      }
    });
  }, []);

  return (
    <div className="rounded-lg border border-stroke bg-white py-6 px-7.5 shadow-default dark:border-strokedark dark:bg-boxdark">
      <div className="flex h-11.5 w-11.5 items-center justify-center rounded-full bg-meta-2 dark:bg-meta-4">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          className="fill-green dark:fill-whites"
          width="24"
          height="24"
          fill="none"
          viewBox="0 -960 960 960"
        >
          <path d="M240-80q-33 0-56.5-23.5T160-160v-640q0-33 23.5-56.5T240-880h320l240 240v480q0 33-23.5 56.5T720-80H240Zm280-520v-200H240v640h480v-440H520ZM240-800v200-200 640-640Z" />
        </svg>
      </div>

      <div className="mt-4 flex items-end justify-between">
        <div>
          <h4 className="text-title-md font-bold text-black dark:text-white">
            {totalDocuments}
          </h4>
          <span className="text-sm font-medium">Document</span>
        </div>
      </div>
    </div>
  );
};

export default CardThree;
