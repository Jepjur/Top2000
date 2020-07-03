using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Top2000.Models;
using PagedList;


namespace Top2000.Controllers
{
    public class SongsController : Controller
    {
        private DB_A63478_DeechteTOP2000Entities db = new DB_A63478_DeechteTOP2000Entities();

        // GET: Songs
        public ActionResult Index(int? page, string currentFilter = "", string sortOrder = "", string searchString = "")
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = sortOrder;
            ViewBag.CurrentFilter = searchString;

            var songs = db.Songs.Include(s => s.Artiest).ToList();
            int pageNumber = (page ?? 1);
            int pageSize = 20;
            switch (sortOrder)
            {
                case "titel_desc":
                    songs = songs.OrderByDescending(a => a.titel).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));

                case "titel_asc":
                    songs = songs.OrderBy(a => a.titel).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));

                case "artiest_desc":
                    songs = songs.OrderByDescending(a => a.Artiest.naam).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));

                case "artiest_asc":
                    songs = songs.OrderBy(a => a.Artiest.naam).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));


                case "year_desc":
                    songs = songs.OrderByDescending(a => a.jaar).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));

                case "year_asc":
                    songs = songs.OrderBy(a => a.jaar).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));

                default:
                    songs = songs.OrderBy(a => a.titel).ToList();
                    return View(songs.Where(a => a.titel.ToLower().Contains(searchString.ToLower()) ||
                    a.Artiest.naam.ToLower().Contains(searchString.ToLower())).ToList().ToPagedList(pageNumber, pageSize));
            }
        }
        // GET: Songs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            return View(song);
        }

        // GET: Songs/Create
        public ActionResult Create()
        {
            ViewBag.artiestid = new SelectList(db.Artiests, "Artiestid", "naam");
            return View();
        }

        // POST: Songs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "songid,artiestid,titel,jaar")] Song song)
        {
            if (ModelState.IsValid)
            {
                db.Songs.Add(song);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.artiestid = new SelectList(db.Artiests, "Artiestid", "naam", song.artiestid);
            return View(song);
        }

        // GET: Songs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            ViewBag.artiestid = new SelectList(db.Artiests, "Artiestid", "naam", song.artiestid);
            return View(song);
        }

        // POST: Songs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "songid,artiestid,titel,jaar")] Song song)
        {
            if (ModelState.IsValid)
            {
                db.Entry(song).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.artiestid = new SelectList(db.Artiests, "Artiestid", "naam", song.artiestid);
            return View(song);
        }

        // GET: Songs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            return View(song);
        }

        // POST: Songs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Song song = db.Songs.Find(id);
            db.Songs.Remove(song);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
