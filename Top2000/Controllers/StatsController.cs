using Top2000.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Top2000.Models;
using PagedList;
using PagedList.Mvc;

namespace Top2000.Controllers
{

    public class StatsController : Controller
    {

        public StatsController()
        {
        }
        private DB_A63478_DeechteTOP2000Entities db = new DB_A63478_DeechteTOP2000Entities();

        /// <summary>
        /// Songs made in one of the Top 2000 years
        /// </summary>
        public ActionResult SongsPerYear(int? page, int year = 0, string sortOrder = "")
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = sortOrder;

            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);
            var list = db.uspSongsPerYear(year).ToList();
            int pageSize = 50;
            int pageNumber = (page ?? 1);
            switch (sortOrder)
            {
                case "titel_desc":
                    list = list.OrderByDescending(a => a.titel).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "titel_asc":
                    list = list.OrderBy(a => a.titel).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "artiest_desc":
                    list = list.OrderByDescending(a => a.naam).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "artiest_asc":
                    list = list.OrderBy(a => a.naam).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
                default:
                    list = list.OrderByDescending(a => a.titel).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
            }
        }
            public ActionResult GoneFromList(int? page, int year = 0, string sortOrder = "")
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = sortOrder;

            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);
            var list = db.uspGoneFromList(year).ToList();
            int pageSize = 50;
            int pageNumber = (page ?? 1);
            switch (sortOrder)
            {
                case "positie_desc":
                    list = list.OrderByDescending(a => a.positie).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "positie_asc":
                    list = list.OrderBy(a => a.positie).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
                
                default:
                    list = list.OrderByDescending(a => a.titel).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
            }
            }
        public ActionResult LostMoreThan100(int? page, int year = 0, string sortOrder = "")
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = sortOrder;
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            var list = db.uspSongsLost100Places(year).ToList();

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            switch (sortOrder)
            {
                case "verschil_desc":
                    list = list.OrderByDescending(a => a.verschil).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "verschil_asc":
                    list = list.OrderBy(a => a.verschil).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                default:
                    list = list.OrderByDescending(a => a.positie).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
            }

        }

        public ActionResult GainedMoreThan100(int? page, int year = 0, string sortOrder = "")
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = sortOrder;
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);
            var list = db.uspSongsGained100Places(year).ToList();
            int pageSize = 50;
            int pageNumber = (page ?? 1);
            switch (sortOrder)
            {
                case "verschil_desc":
                    list = list.OrderByDescending(a => a.verschil).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                case "verschil_asc":
                    list = list.OrderBy(a => a.verschil).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));

                default:
                    list = list.OrderByDescending(a => a.positie).ToList();
                    return View(list.ToList().ToPagedList(pageNumber, pageSize));
            }

        }

        public ActionResult SamePlace(int? page, int year = 0)
        {
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            return View(db.uspSongsOnSamePosition(year).ToList().ToPagedList(pageNumber, pageSize));
        }

        public ActionResult NewlyListed(int? page, int year = 0)
        {
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            return View(db.uspNewlyListed(year).ToList().ToPagedList(pageNumber, pageSize));
        }

        public ActionResult ArtiestWithMuchSongs(int? page, int year = 0)
        {
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            return View(db.uspArtistWithMuchSongs(year).ToList().OrderByDescending(a=>a.Aantal_songs).ToPagedList(pageNumber, pageSize));
        }
        public ActionResult GainedPlaces(int? page, int year = 0)
        {
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            return View(db.uspSongsGainedPlaces(year).ToList().ToPagedList(pageNumber, pageSize));
        }

        public ActionResult LostPlaces(int? page, int year = 0)
        {
            ViewBag.CurrentFilter = year;
            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);

            int pageSize = 50;
            int pageNumber = (page ?? 1);

            return View(db.uspSongsLostPlaces(year).ToList().ToPagedList(pageNumber, pageSize));
        }


    }
}