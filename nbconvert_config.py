"""
Source: http://mcwitt.github.io/2015/04/29/jekyll_blogging_with_ipython3/
"""

from urllib.parse import quote  # Py 3
import os


def path2url(path):
    """Turn a file path into a URL"""
    parts = path.split(os.path.sep)
    return '{{ site.baseurl }}/notebooks/' + '/'.join(quote(part) for part in parts)

################################################################################

c = get_config()
c.NbConvertApp.export_format = 'markdown'
c.MarkdownExporter.template_file = 'nbconvert-jekyll-post'
c.FilesWriter.build_directory = 'source/notebooks'
c.MarkdownExporter.filters = {'path2url': path2url}
c.Exporter.preprocessors = ['nbconvert_utils.JekyllPreprocessor']
c.NbConvertApp.postprocessor_class = 'nbconvert_utils.Rename'
