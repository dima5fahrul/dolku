import Breadcrumb from '../../components/Breadcrumb';
import { NavLink } from 'react-router-dom';
import { useEffect } from 'react';
import { onAuthStateChanged } from 'firebase/auth';
import { auth } from '../../components/firebase/Config';
import { useNavigate } from 'react-router-dom';

const FormUpload = () => {
  const Navigate = useNavigate();

  useEffect(() => {
    onAuthStateChanged(auth, (user) => {
      if (user) {
        // User is signed in, see docs for a list of available properties
        // https://firebase.google.com/docs/reference/js/firebase.User
        const uid = user.uid;
        console.log('uid', uid);
      } else {
        // User is signed out
        Navigate('/signin');
        console.log('user is logged out');
      }
    });
  }, []);

  return (
    <>
      <div className="mx-auto">
        <Breadcrumb pageName="Data Management" />

        <div className="flex justify-center items-center">
          <div className="w-full xl:w-1/2 justify-self-center justify-center justify-items-center content-center items-center self-center rounded-sm border border-stroke bg-white shadow-default dark:border-strokedark dark:bg-boxdark">
            <div className="border-b border-stroke py-4 px-6.5 dark:border-strokedark">
              <h3 className="font-medium text-black dark:text-white">
                Form Upload File
              </h3>
            </div>
            <form
              id="form-upload"
              action="http://127.0.0.1:5000/api/upload/pdf"
              method="post"
              encType="multipart/form-data"
            >
              <div className="p-6">
                <div className="mb-5 flex flex-col gap-6">
                  <div className="w-full">
                    <label
                      className="mb-2.5 block text-black dark:text-white"
                      htmlFor="name"
                    >
                      Name
                    </label>
                    <input
                      type="text"
                      id="filename"
                      name="filename"
                      placeholder="File name"
                      className="w-full rounded border-2 border-stroke bg-transparent py-3 px-5 font-medium outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:focus:border-primary"
                      required
                    />
                  </div>
                </div>

                <div className="mb-5">
                  <label
                    className="mb-2.5 block text-black dark:text-white"
                    htmlFor="description"
                  >
                    Description
                  </label>
                  <textarea
                    rows={window.innerWidth < 764 ? 8 : 6}
                    id="description"
                    name="description"
                    placeholder="File description"
                    className="w-full rounded border-2 border-stroke bg-transparent py-3 px-5 font-medium outline-none transition focus:border-primary active:border-primary disabled:cursor-default disabled:bg-whiter dark:border-form-strokedark dark:bg-form-input dark:focus:border-primary"
                    required
                  ></textarea>
                </div>

                <div className="flex gap-4">
                  <NavLink
                    to="/data-management"
                    className="flex w-1/2 justify-center rounded text-danger border transition hover:text-white hover:bg-danger focus:outline-none dark:focus:outline-none dark:hover:bg-danger p-3 font-medium"
                  >
                    Cancel
                  </NavLink>
                  <button
                    type="submit"
                    className="flex w-1/2 justify-center rounded bg-green p-3 font-medium text-white transition hover:bg-greendark"
                  >
                    Upload
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
};

export default FormUpload;
