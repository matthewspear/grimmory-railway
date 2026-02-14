FROM booklore/booklore:latest

RUN mkdir -p /booklore-data/app-data /booklore-data/books /booklore-data/bookdrop \
    && rm -rf /app/data /books /bookdrop \
    && ln -s /booklore-data/app-data /app/data \
    && ln -s /booklore-data/books /books \
    && mkdir -p /bookdrop
