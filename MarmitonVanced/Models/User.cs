﻿namespace MarmitonVanced.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public string Surname { get; set; } = "";
        public string Mail { get; set; } = "";
        public string Password { get; set; } = "";
        public string State { get; set; } = "";
    }
}
