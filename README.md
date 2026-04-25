

# 🚀 Terraform Project Setup & Git Workflow Guide

This document explains how to safely manage Terraform projects using Git and push them to GitHub without errors (especially large file issues like `.terraform`).

---

# 📁 1. Project Structure

```
Terraform/
│
├── New_Project/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│
└── .gitignore
```

---

# ⚠️ 2. Important Rule (MUST KNOW)

Terraform creates a folder called:

```
.terraform/
```

👉 This folder contains:

* Provider binaries (very large files)
* Cache files

❌ NEVER push this folder to GitHub
👉 GitHub has a **100 MB file size limit**, and this folder often exceeds it.

---

# ✅ 3. Setup `.gitignore`

Create a `.gitignore` file in the root directory:

```bash
touch .gitignore
```

Add the following content:

```gitignore
# Ignore Terraform local files
**/.terraform/*
*.tfstate
*.tfstate.backup
```

👉 This ensures:

* `.terraform` is never tracked
* State files are not exposed

---

# 🛠️ 4. Initialize Terraform Project

Navigate to your project folder:

```bash
cd Terraform/New_Project
```

Initialize Terraform:

```bash
terraform init
```

👉 This downloads provider plugins into `.terraform/` (which will be ignored by Git).

---

# 🔍 5. Verify Before Committing

Go back to root:

```bash
cd ../../
```

Check status:

```bash
git status
```

👉 Ensure:

* `.terraform/` ❌ NOT visible
* `.tf` files ✅ visible

---

# 🚀 6. Push Code to GitHub (First Time)

### Step 1: Initialize Git

```bash
git init
```

### Step 2: Add files

```bash
git add .
```

### Step 3: Commit

```bash
git commit -m "Initial Terraform project"
```

### Step 4: Connect to GitHub repo

```bash
git remote add origin https://github.com/<your-username>/<repo-name>.git
```

### Step 5: Push

```bash
git branch -M main
git push -u origin main
```

---

# 🔄 7. Regular Workflow (For New Changes)

Whenever you add/update files:

```bash
git status
git add .
git commit -m "Updated Terraform configuration"
git push origin main
```

---

# 📦 8. Adding a New Folder / Project

Create a new project:

```bash
mkdir -p Terraform/New_Project
```

Add Terraform files, then:

```bash
git status
git add .
git commit -m "Added new Terraform project"
git push origin main
```

---

# 🔁 9. Moving Code to a New Repository

## Option 1: Change Remote (Keep History)

```bash
git remote set-url origin https://github.com/<your-username>/<new-repo>.git
git push -u origin main
```

---

## Option 2: Clean New Repo (Recommended)

```bash
mkdir Terraform-New
cd Terraform-New

# Copy only required files (DO NOT copy .terraform)
cp -r ../OldProject/*.tf .

git init
touch .gitignore
```

Add `.gitignore` content (same as above), then:

```bash
git add .
git commit -m "Clean Terraform project"
git remote add origin https://github.com/<your-username>/<new-repo>.git
git branch -M main
git push -u origin main
```

---

# 🧹 10. If `.terraform` Gets Committed by Mistake

## Remove from tracking:

```bash
git rm -r --cached **/.terraform
git add .
git commit -m "Removed .terraform files"
git push origin main
```

---

# 💣 11. If Push Fails (Large File Error)

👉 This means `.terraform` exists in Git history.

## Fix using history cleanup:

```bash
git filter-repo --path .terraform --invert-paths --force
git remote add origin https://github.com/<your-username>/<repo-name>.git
git push -u origin main --force
```

---

# 🧠 12. Best Practices (Industry Standard)

* Never commit `.terraform/`
* Never commit `.tfstate` files
* Use remote backend for state storage
* Keep repository clean and structured
* Use meaningful commit messages

---

# 🎯 13. Interview Explanation

> “We use `.gitignore` to exclude `.terraform` and state files. If large files are committed, we clean Git history using git-filter-repo. For better collaboration, we store Terraform state in remote backends like AWS S3 or Azure Storage.”

---

# 🚀 14. Final Workflow Summary

1. Create project
2. Add `.gitignore`
3. Run `terraform init`
4. Check `git status`
5. Add → Commit → Push

---

✔️ This ensures:

* Clean repository
* No large file errors
* Industry-standard workflow

---

---
