FROM cadic/pymeshlab:vanilla

# Add wheels
COPY dist/*.whl /tmp/
RUN pip install /tmp/*.whl
