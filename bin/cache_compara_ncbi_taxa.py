#!/usr/bin/env python
"""

    cache_compara_ncbi_taxa.py
    [--log_file PATH]
    [--verbose]

"""

################################################################################
#
#   cache_compara_taxa
#
#
#   Copyright (c) 6/1/2010 Leo Goodstadt
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.
#################################################################################

import sys, os

# add self to search path for testing
if __name__ == '__main__':
    exe_path = os.path.split(os.path.abspath(sys.argv[0]))[0]
    module_name = os.path.split(sys.argv[0])[1]
    module_name = os.path.splitext(module_name)[0];
else:
    module_name = __name__

# Use import path from <<..>>
if __name__ == '__main__':
    sys.path.append(os.path.abspath(os.path.join(exe_path,"..")))



#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

#   options


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888


if __name__ == '__main__':
    from optparse import OptionParser
    import StringIO

    parser = OptionParser(version="%prog 1.0", usage = "\n\n    %prog [options]")
    parser.add_option("-i", "--index_file", dest="index_file",
                      metavar="FILE",
                      type="string",
                      help="Name and path of index of compara NCBI taxa data.")
    parser.add_option("-d", "--data_directory", dest="data_directory",
                      metavar="PATH",
                      type="string",
                      help="Where data should be cached.")
    parser.add_option("--ensembl_version", dest="ensembl_version",
                      metavar="NUMBER",
                      type="int",
                      help="Ensembl version to cache. Defaults to latest version.")
    parser.add_option("--list_versions", dest="list_versions",
                      action="store_true", default=False,
                      help="List available versions.")
    parser.add_option("--discard_cache", dest="discard_cache",
                      action="store_true", default=False,
                      help="Discard previously cached data.")
    parser.add_option("--summarize_cache", dest="summarize_cache",
                      action="store_true", default=False,
                      help="Summarize cached data.")
    parser.add_option("--password", dest="password",
                      type="string",
                      help="Password for mysql Ensembl database connection.")
    parser.add_option("--user", dest="user",
                      type="string",
                      help="User name for mysql Ensembl database connection.")
    parser.add_option("--host", dest="host",
                      type="string",
                      help="Host for mysql Ensembl database connection.")
    parser.add_option("--port", dest="port",
                      type="int",
                      help="Port for mysql Ensembl database connection.")


    #
    #   general options: verbosity / logging
    #
    parser.add_option("-v", "--verbose", dest = "verbose",
                      action="count", default=0,
                      help="Print more verbose messages for each additional verbose level.")
    parser.add_option("-L", "--log_file", dest="log_file",
                      metavar="FILE",
                      type="string",
                      help="Name and path of log file")
    parser.add_option("--skip_parameter_logging", dest="skip_parameter_logging",
                        action="store_true", default=False,
                        help="Do not print program parameters to log.")
    parser.add_option("--debug", dest="debug",
                        action="count", default=0,
                        help="Set default program parameters in debugging mode.")




    # get help string
    f =StringIO.StringIO()
    parser.print_help(f)
    helpstr = f.getvalue()
    original_args = " ".join(sys.argv)
    (options, remaining_args) = parser.parse_args()


    #vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    #                                             #
    #   Debug: Change these                       #
    #                                             #
    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    if options.debug:
        options.log_file       = "/net/cpp-mirror/databases/ensembl_cache/compara_ncbi_taxa.log"
        options.index_file     = "/net/cpp-mirror/databases/ensembl_cache/compara_ncbi_taxa.index"
        options.data_directory = "/net/cpp-mirror/databases/ensembl_cache/compara/ncbi_taxa"
        options.verbose                 = 1
        options.log_parameters          = True
    #vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    #                                             #
    #   Debug: Change these                       #
    #                                             #
    #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    #
    #   mandatory options
    #
    def check_mandatory_options (options, mandatory_options, helpstr):
        """
        Check if specified mandatory options have b een defined
        """
        missing_options = []
        for o in mandatory_options:
            if not getattr(options, o):
                missing_options.append("--" + o)

        if not len(missing_options):
            return

        raise Exception("Missing mandatory parameter%s: %s.\n\n%s\n\n" %
                        ("s" if len(missing_options) > 1 else "",
                         ", ".join(missing_options),
                         helpstr))


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

#   imports


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
import re
from cache_ensembl import *


#from json import dumps
#from collections import defaultdict



#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

#   Functions


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

#   Logger


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

if __name__ == '__main__':
    import logging
    import logging.handlers

    MESSAGE = 15
    logging.addLevelName(MESSAGE, "MESSAGE")

    def setup_std_logging (logger, log_file, verbose):
        """
        set up logging using programme options
        """
        class debug_filter(logging.Filter):
            """
            Ignore INFO messages
            """
            def filter(self, record):
                return logging.INFO != record.levelno

        class NullHandler(logging.Handler):
            """
            for when there is no logging
            """
            def emit(self, record):
                pass

        # We are interesting in all messages
        logger.setLevel(logging.DEBUG)
        has_handler = False

        # log to file if that is specified
        if log_file:
            handler = logging.FileHandler(log_file, delay=False)
            handler.setFormatter(logging.Formatter("%(asctime)s - %(name)s - %(levelname)6s - %(message)s"))
            handler.setLevel(MESSAGE)
            logger.addHandler(handler)
            has_handler = True

        # log to stderr if verbose
        if verbose:
            stderrhandler = logging.StreamHandler(sys.stderr)
            stderrhandler.setFormatter(logging.Formatter("    %(message)s"))
            stderrhandler.setLevel(logging.DEBUG)
            if log_file:
                stderrhandler.addFilter(debug_filter())
            logger.addHandler(stderrhandler)
            has_handler = True

        # no logging
        if not has_handler:
            logger.addHandler(NullHandler())


    #
    #   set up log
    #
    logger = logging.getLogger(module_name)
    setup_std_logging(logger, options.log_file, options.verbose)


    #
    #   log programme parameters
    #
    if not options.skip_parameter_logging:
        programme_name = os.path.split(sys.argv[0])[1]
        logger.info("%s %s" % (programme_name, original_args))

#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

#   Main logic


#88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
if __name__ == '__main__':
#   debug code not run if called as a module
#

    #
    #   check if use different mysql host
    #
    connection_settings = {}
    for setting in 'user', 'password', 'port', 'host':
        if getattr(options, setting):
            connection_settings[setting] = getattr(options, setting)



    dbh = connect_ensembl_mysql(**connection_settings)
    compara_db_per_version = get_compara_databases (dbh)

    #
    #   List versions
    #
    if options.list_versions:
        print ("Available Ensembl compara versions are:\n    " +
                ", ".join(map(str, sorted(compara_db_per_version.keys(), reverse = True))) +
                "\n")
        sys.exit()


    #
    #   use latest version
    #
    if not options.ensembl_version:
        options.ensembl_version = max(compara_db_per_version.keys())
    elif options.ensembl_version not in compara_db_per_version:
        raise Exception("Version %d is not available from the Ensembl database.\n")


    check_mandatory_options (options, ["index_file"], helpstr)

    #
    #   Only summarize what is in cache
    #
    if options.summarize_cache:

        (   taxon_id_to_scientific_name,
            taxon_id_to_common_name ,
            taxon_id_to_parent      ,
            ensembl_version         ,
            cache_file_name         ) = get_compara_ncbi_taxa(options.index_file, logger,
                                                              ensembl_version = options.ensembl_version)
        if taxon_id_to_scientific_name != None:

            logger.log(MESSAGE, "  %7d taxa downloaded" % len(taxon_id_to_parent))
            logger.log(MESSAGE, "  %7d taxa scientific names downloaded" % len(taxon_id_to_scientific_name))
            logger.log(MESSAGE, "  %7d taxa common names downloaded" % len(taxon_id_to_common_name))

        sys.exit()

    #
    #   Cache
    #
    logger.log(MESSAGE, "Cache taxa from Ensembl Compara v. %d" % (options.ensembl_version))
    check_mandatory_options (options, ["index_file", "data_directory"], helpstr)
    cache_compara_ncbi_taxa(dbh,
                            options.index_file,
                            options.data_directory,
                            logger,
                            ensembl_versions = options.ensembl_version,
                            discard_cache    = options.discard_cache)













