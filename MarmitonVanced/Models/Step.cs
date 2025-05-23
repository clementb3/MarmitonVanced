namespace MarmitonVanced.Models
{
    public class Step
    {
        public int Id { get; set; }
        public int IdRecipe { get; set; }
        public string Desc { get; set; } = "";
        public int Pos { get; set; }
    }
}
