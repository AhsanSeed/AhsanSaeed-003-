import tkinter as tk
from tkinter import *

from tkinter import ttk, messagebox
import mysql.connector

root = Tk(className=' Real Estate Management System')
root.geometry("800x500")
root.configure(bg='light blue')
global e1
global e2
global e3
global e4

tk.Label(root, text="Plot number").place(x=10, y=40)
Label(root, text="Owner Name").place(x=10, y=70)
Label(root, text="Size").place(x=10, y=100)
Label(root, text="Price").place(x=10, y=130)

e1 = Entry(root)
e1.place(x=140, y=40)

e2 = Entry(root)
e2.place(x=140, y=70)

e3 = Entry(root)
e3.place(x=140, y=100)

e4 = Entry(root)
e4.place(x=140, y=130)


def Add():
    studid = e1.get()
    studname = e2.get()
    coursename = e3.get()
    feee = e4.get()

    mysqldb = mysql.connector.connect(host="localhost", user="root", password="", database="realestate")
    mycursor = mysqldb.cursor()

    try:
        sql = "INSERT INTO realestatemanagement (plotid,ownername,size,price) VALUES (%s, %s, %s, %s)"
        val = (studid, studname, coursename, feee)
        mycursor.execute(sql, val)
        mysqldb.commit()
        lastid = mycursor.lastrowid
        messagebox.showinfo("", "Plot added!")
        e1.delete(0, END)
        e2.delete(0, END)
        e3.delete(0, END)
        e4.delete(0, END)
        e1.focus_set()

    except Exception as e:
        print(e)
        mysqldb.rollback()
        mysqldb.close()


def update():
    studid = e1.get()
    studname = e2.get()
    coursename = e3.get()
    feee = e4.get()
    mysqldb = mysql.connector.connect(host="localhost", user="root", password="", database="realestate")
    mycursor = mysqldb.cursor()

    try:
        sql = "Update  realestatemanagement set ownername= %s,size= %s,price= %s where plotid= %s"
        val = (studname, coursename, feee, studid)
        mycursor.execute(sql, val)
        mysqldb.commit()
        lastid = mycursor.lastrowid
        messagebox.showinfo("", "Plot Updated")

        e1.delete(0, END)
        e2.delete(0, END)
        e3.delete(0, END)
        e4.delete(0, END)
        e1.focus_set()

    except Exception as e:

        print(e)
        mysqldb.rollback()
        mysqldb.close()


def search():
    mysqldb = mysql.connector.connect(host="localhost", user="root", password="", database="realestate")
    mycursor = mysqldb.cursor()
    mycursor.execute("SELECT plotid,ownername,size,price FROM realestatemanagement")
    records = mycursor.fetchall()
    # print(records)

    rec = records[0]
    msg = "Plot number : " + str(rec[0]) + "\n" + "Owner name : " + str(rec[1]) + "\n" + "Size : " + str(
        rec[2]) + "\n" + "Price : " + str(rec[3])

    for i, (plotid, ownername, size, price) in enumerate(records, start=1):
        messagebox.showinfo("Plot Details", msg)
        mysqldb.close()


def delete():
    studid = e1.get()

    mysqldb = mysql.connector.connect(host="localhost", user="root", password="", database="realestate")
    mycursor = mysqldb.cursor()

    try:
        sql = "delete from realestatemanagement where plotid = %s"
        val = (studid,)
        mycursor.execute(sql, val)
        mysqldb.commit()
        lastid = mycursor.lastrowid
        messagebox.showinfo("", "Plot deleted!")

        e1.delete(0, END)
        e2.delete(0, END)
        e3.delete(0, END)
        e4.delete(0, END)
        e1.focus_set()

    except Exception as e:

        print(e)
        mysqldb.rollback()
        mysqldb.close()


def GetValue(event):
    e1.delete(0, END)
    e2.delete(0, END)
    e3.delete(0, END)
    e4.delete(0, END)
    row_id = listBox.selection()[0]
    select = listBox.set(row_id)
    e1.insert(0, select['plotid'])
    e2.insert(0, select['ownername'])
    e3.insert(0, select['size'])
    e4.insert(0, select['price'])


def show():
    mysqldb = mysql.connector.connect(host="localhost", user="root", password="", database="realestate")
    mycursor = mysqldb.cursor()
    mycursor.execute("SELECT plotid,ownername,size,price FROM realestatemanagement")
    records = mycursor.fetchall()
    # print(records)

    for i, (id, empname, mobile, salary) in enumerate(records, start=1):
        listBox.insert("", "end", values=(id, empname, mobile, salary))
        mysqldb.close()


Button(root, text="Add", command=Add, height=3, width=13).place(x=30, y=160)
Button(root, text="Update", command=update, height=3, width=13).place(x=140, y=160)
Button(root, text="Delete", command=delete, height=3, width=13).place(x=250, y=160)
Button(root, text="Search", command=search, height=3, width=13).place(x=360, y=160)

cols = ('Plot number', 'Owner Name', 'Size', 'Price')
listBox = ttk.Treeview(root, columns=cols, show='headings')

for col in cols:
    listBox.heading(col, text=col)
    listBox.grid(row=1, column=0, columnspan=2)
    listBox.place(x=1, y=260)

show()
listBox.bind('<Double-Button-1>', GetValue)

root.mainloo