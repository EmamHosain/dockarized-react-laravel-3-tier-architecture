const ProductSkeleton = () => {
    return (
        <div className="animate-pulse">
            <div className="h-48 bg-gray-300 rounded-t-xl"></div>

            <div className="p-4">
                <div className="h-4 bg-gray-300 rounded"></div>

                <div className="h-4 bg-gray-300 rounded mt-3"></div>

                <div className="h-4 bg-gray-300 rounded mt-3 w-20"></div>
            </div>
        </div>
    );
};

export default ProductSkeleton;