const Loader = (props: any) => {
  return (
    <div
      className={`flex ${props.height} mx-auto my-auto items-center justify-center bg-white dark:bg-boxdark`}
    >
      <div className="h-16 w-16 animate-spin rounded-full border-4 border-solid border-primary border-t-transparent"></div>
    </div>
  );
};

export default Loader;
