import { useEffect, useState } from "react";
import axios from 'axios'
import Navbar from "../components/Navbar";
import Hero from "../components/Hero";
import Footer from "../components/Footer";

import ProductCard from "../components/ProductCard";
import ProductSkeleton from "../components/ProductSkeleton";

// import api from "../services/api";
import type { Product } from "../types/product";

const Home = () => {
    const [products, setProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const getProducts = async () => {
            try {
                const response = await axios.get('/api/products')
                setProducts(response.data.products.data);
            } catch (error) {
                console.error('API Error:', error)
            } finally {
                setLoading(false);
            }
        }
        getProducts();
    }, []);

    return (
        <>
            <Navbar />

            <Hero />

            <section className="container mx-auto px-4 py-20">
                <h2 className="text-3xl font-bold mb-10">
                    Featured Products
                </h2>

                <div className="grid md:grid-cols-3 gap-8">
                    {loading
                        ? Array.from({ length: 12 }).map((_, i) => (
                            <ProductSkeleton key={i} />
                        ))
                        : products.map((product) => (
                            <ProductCard
                                key={product.id}
                                product={product}
                            />
                        ))}
                </div>
            </section>

            <Footer />
        </>
    );
};

export default Home;