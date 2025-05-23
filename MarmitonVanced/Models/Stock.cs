namespace MarmitonVanced.Models
{
    public class Stock
    {
        public int Id { get; set; }
        public required Ingredient IngredientStock { get; set; }
        public int Quantity { get; set; }

    }
}
