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
        const documentsCollection = collection(db, 'report');
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
          className="fill-green dark:fill-white"
          width="24"
          height="24"
          fill="none"
          viewBox="0 -960 960 960"
        >
          <path d="M480-360q17 0 28.5-11.5T520-400q0-17-11.5-28.5T480-440q-17 0-28.5 11.5T440-400q0 17 11.5 28.5T480-360Zm-40-160h80v-240h-80v240ZM80-80v-720q0-33 23.5-56.5T160-880h640q33 0 56.5 23.5T880-800v480q0 33-23.5 56.5T800-240H240L80-80Zm126-240h594v-480H160v525l46-45Zm-46 0v-480 480Z" />
        </svg>
      </div>

      <div className="mt-4 flex items-end justify-between">
        <div>
          <h4 className="text-title-md font-bold text-black dark:text-white">
            {totalDocuments}
          </h4>
          <span className="text-sm font-medium">No Answer</span>
        </div>
      </div>
    </div>
  );
};

export default CardThree;
