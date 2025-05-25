namespace MarmitonVanced.Models
{
    public class Purchase
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public int Quantity { get; set; }
        public List<String> Recipes { get; set; } = [];
        public TypeQuantity Type { get; set; } = TypeQuantity.U;
        public decimal Price { get; set; } = 0;
    }
}
