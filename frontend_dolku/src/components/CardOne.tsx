import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { icon } from '@fortawesome/fontawesome-svg-core/import.macro';
import { faUser } from '@fortawesome/free-solid-svg-icons';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { onAuthStateChanged } from 'firebase/auth';
import { auth, db } from './firebase/Config';
import { getDocs, collection } from 'firebase/firestore';

const CardOne = () => {
  const Navigate = useNavigate();
  const [totalHistory, setTotalHistory] = useState(0);

  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        const uid = user.uid;
        const historyCollection = collection(db, 'chatHistory');
        getDocs(historyCollection)
          .then((querySnapshot) => {
            const total = querySnapshot.size;
            setTotalHistory(total);
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
          className='fill-green dark:fill-white'
          width="24"
          height="24"
          fill='none'
          viewBox="0 -960 960 960"
        >
          <path d="M120-120v-80l80-80v160h-80Zm160 0v-240l80-80v320h-80Zm160 0v-320l80 81v239h-80Zm160 0v-239l80-80v319h-80Zm160 0v-400l80-80v480h-80ZM120-327v-113l280-280 160 160 280-280v113L560-447 400-607 120-327Z" />
        </svg>
      </div>
      <div className="mt-4 flex items-end justify-between">
        <div>
          <h4 className="text-title-md font-bold text-black dark:text-white">
            {totalHistory}
          </h4>
          <span className="text-sm font-medium">Activities</span>
        </div>
      </div>
    </div>
  );
};

export default CardOne;
