from django.db import models

class Blog(models.Model):
    title = models.CharField(max_length=200)
    data = models.DateField()
    description = models.TextField()
    image = models.ImageField(upload_to='portfolio/images/')
    url = models.URLField(blank=True)
