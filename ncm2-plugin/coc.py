# -*- coding: utf-8 -*-

def wrap():
    from ncm2_core import ncm2_core
    from ncm2 import getLogger
    import vim

    # def matches_do_popup(self, ctx, startccol, matches):

    old_matches_do_popup = ncm2_core.matches_do_popup

    def new_matches_do_popup(*args):
        matches = args[2]
        for m in matches:
            if 'coc_user_data' in m:
                m['user_data'] = m['coc_user_data']
        return old_matches_do_popup(*args)

    ncm2_core.matches_do_popup = new_matches_do_popup

wrap()
