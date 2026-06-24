const Navbar = () => {
    return (
        <nav className="bg-white shadow">
            <div className="container mx-auto px-4 py-4 flex justify-between">
                <h1 className="font-bold text-2xl">
                    Shop
                </h1>

                <div className="flex gap-6">
                    <a href="#">Home</a>
                    <a href="#">Products</a>
                    <a href="#">Contact</a>
                </div>
            </div>
        </nav>
    );
};

export default Navbar;