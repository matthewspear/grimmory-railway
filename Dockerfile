FROM grimmory/grimmory:v2.3.1

ENV PORT=6060

# Pre-create volume structure (will be populated at runtime)
RUN mkdir -p /booklore-data/app-data /booklore-data/books /bookdrop

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["java", "--enable-native-access=ALL-UNNAMED", "--enable-preview", "-jar", "/app/app.jar"]
