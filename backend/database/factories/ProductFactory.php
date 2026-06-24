<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $colors = [
            '#ef4444',
            '#22c55e',
            '#3b82f6',
            '#f97316',
            '#8b5cf6',
            '#ec4899',
            '#14b8a6',
            '#eab308',
        ];

        return [
            'name' => fake()->words(2, true),
            'description' => fake()->sentence(),
            'price' => fake()->numberBetween(500, 5000),
            'color' => fake()->randomElement($colors),
        ];
    }
}
