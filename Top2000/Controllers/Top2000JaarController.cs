using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Top2000.Models;

namespace Top2000.Controllers
{
    public class Top2000JaarController : Controller
    {
        private DB_A63478_DeechteTOP2000Entities db = new DB_A63478_DeechteTOP2000Entities();

        // GET: Top2000Jaar
        public ActionResult Index()
        {
            return View(db.Top2000Jaar.ToList());
        }

        // GET: Top2000Jaar/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Top2000Jaar top2000Jaar = db.Top2000Jaar.Find(id);
            if (top2000Jaar == null)
            {
                return HttpNotFound();
            }
            return View(top2000Jaar);
        }

        // GET: Top2000Jaar/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Top2000Jaar/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Jaar,Titel")] Top2000Jaar top2000Jaar)
        {
            if (ModelState.IsValid)
            {
                db.Top2000Jaar.Add(top2000Jaar);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(top2000Jaar);
        }

        // GET: Top2000Jaar/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Top2000Jaar top2000Jaar = db.Top2000Jaar.Find(id);
            if (top2000Jaar == null)
            {
                return HttpNotFound();
            }
            return View(top2000Jaar);
        }

        // POST: Top2000Jaar/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Jaar,Titel")] Top2000Jaar top2000Jaar)
        {
            if (ModelState.IsValid)
            {
                db.Entry(top2000Jaar).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(top2000Jaar);
        }

        // GET: Top2000Jaar/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Top2000Jaar top2000Jaar = db.Top2000Jaar.Find(id);
            if (top2000Jaar == null)
            {
                return HttpNotFound();
            }
            return View(top2000Jaar);
        }

        // POST: Top2000Jaar/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Top2000Jaar top2000Jaar = db.Top2000Jaar.Find(id);
            db.Top2000Jaar.Remove(top2000Jaar);
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
