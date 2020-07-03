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
    public class LijstsController : Controller
    {
        private DB_A63478_DeechteTOP2000Entities db = new DB_A63478_DeechteTOP2000Entities();

        // GET: Lijsts
        public ActionResult Index(int? page, int year = 0, string sortOrder = "")
        {
            ViewBag.CurrentFilter = year;
            ViewBag.CurrentSort = sortOrder;

            if (year == 0) year = db.Top2000Jaar.Max(y => y.Jaar);
            ViewBag.year = new SelectList(db.Top2000Jaar, "Jaar", "Titel", year);
            var lijsts = db.Lijsts.Include(l => l.Song).Include(l => l.Top2000Jaar1).Include(l=>l.Song.Artiest).ToList();
            int pageNumber = (page ?? 1);
            int pageSize = 20;

            return View(lijsts.Where(l => l.top2000jaar == year).OrderBy(a => a.positie).ToList().ToPagedList(pageNumber, pageSize));
        }


        // GET: Lijsts/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Lijst lijst = db.Lijsts.Find(id);
            if (lijst == null)
            {
                return HttpNotFound();
            }
            return View(lijst);
        }

        // GET: Lijsts/Create
        public ActionResult Create()
        {
            ViewBag.songid = new SelectList(db.Songs, "songid", "titel");
            ViewBag.top2000jaar = new SelectList(db.Top2000Jaar, "Jaar", "Titel");
            return View();
        }

        // POST: Lijsts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "songid,top2000jaar,positie")] Lijst lijst)
        {
            if (ModelState.IsValid)
            {
                db.Lijsts.Add(lijst);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.songid = new SelectList(db.Songs, "songid", "titel", lijst.songid);
            ViewBag.top2000jaar = new SelectList(db.Top2000Jaar, "Jaar", "Titel", lijst.top2000jaar);
            return View(lijst);
        }

        // GET: Lijsts/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Lijst lijst = db.Lijsts.Find(id);
            if (lijst == null)
            {
                return HttpNotFound();
            }
            ViewBag.songid = new SelectList(db.Songs, "songid", "titel", lijst.songid);
            ViewBag.top2000jaar = new SelectList(db.Top2000Jaar, "Jaar", "Titel", lijst.top2000jaar);
            return View(lijst);
        }

        // POST: Lijsts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "songid,top2000jaar,positie")] Lijst lijst)
        {
            if (ModelState.IsValid)
            {
                db.Entry(lijst).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.songid = new SelectList(db.Songs, "songid", "titel", lijst.songid);
            ViewBag.top2000jaar = new SelectList(db.Top2000Jaar, "Jaar", "Titel", lijst.top2000jaar);
            return View(lijst);
        }

        // GET: Lijsts/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Lijst lijst = db.Lijsts.Find(id);
            if (lijst == null)
            {
                return HttpNotFound();
            }
            return View(lijst);
        }

        // POST: Lijsts/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Lijst lijst = db.Lijsts.Find(id);
            db.Lijsts.Remove(lijst);
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
