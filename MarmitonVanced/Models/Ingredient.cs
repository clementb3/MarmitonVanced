namespace MarmitonVanced.Models
{
    public class Ingredient
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public int Quantity { get; set; }
        public TypeQuantity Type { get; set; } = TypeQuantity.U;
    }
}
