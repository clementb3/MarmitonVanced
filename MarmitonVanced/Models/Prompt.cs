namespace MarmitonVanced.Models
{
    public class Prompt
    {
        public int Id { get; set; }
        public string Request { get; set; } = "";
        public List<Recipe> Recipes { get; set; } = new List<Recipe>();
    }
}
