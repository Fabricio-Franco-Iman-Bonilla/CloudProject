using Microsoft.EntityFrameworkCore;
using Proyecto.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Proyecto.Tests.Helpers
{
    public static class InMemoryContextFactory
    {
        public static ProyectoContext Create(string dbName) =>
          new ProyectoContext(
            new DbContextOptionsBuilder<ProyectoContext>()
              .UseInMemoryDatabase(dbName)
              .Options
          );
    }
}