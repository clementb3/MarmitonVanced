using MarmitonVanced.Abstract;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium;
using System;
using MarmitonVanced.Models;
using Microsoft.Data.SqlClient;
using System.Xml.Linq;

namespace MarmitonVanced.Service
{
    public class IaService : IIaService
    {
        public List<int> getRecipes(string request)
        {
            return [0,1,2];
        }
    }
}
