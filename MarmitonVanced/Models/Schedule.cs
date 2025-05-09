namespace MarmitonVanced.Models
{
    public class Schedule
    {
        public int Id { get; set; }
        public int IdRecipe { get; set; }
        public int IdUser { get; set; }
        public DateTime Date { get; set; }
    }
}
