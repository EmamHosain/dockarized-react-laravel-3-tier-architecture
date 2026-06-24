import type { Product } from "../types/product";

type Props = {
    product: Product;
};

const ProductCard = ({ product }: Props) => {
    return (
        <div className="bg-white rounded-xl shadow hover:shadow-lg transition">
            <div
                className="h-48 rounded-t-xl"
                style={{
                    backgroundColor: product.color,
                }}
            />

            <div className="p-4">
                <h3 className="font-semibold">
                    {product.name}
                </h3>

                <p className="text-gray-500 mt-2">
                    {product.description}
                </p>

                <p className="font-bold mt-4">
                    ${product.price}
                </p>
            </div>
        </div>
    );
};

export default ProductCard;