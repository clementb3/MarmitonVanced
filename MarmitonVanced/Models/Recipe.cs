namespace MarmitonVanced.Models
{
    public class Recipe
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public TimeSpan Time { get; set; }
        public string Image { get; set; }
        public User Creator { get; set; }
        public string Type { get; set; }
        public string Description { get; set; }
        public List<Ingredient> Ingredients { get; set; } = [];
        public List<Step> Steps { get; set; } = [];
    }
}
