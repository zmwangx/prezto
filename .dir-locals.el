((nil .
      ((auto-insert-alist .
                          (("\.md\\'" nil
                            ;; Markdown template
                            _ \n
                            \n
                            "## Authors" \n
                            "* [" user-full-name "](" (concat "https://github.com/"
                                                              (car (split-string user-mail-address "@"))) ")" \n)
                           ("" nil
                            ;; Shell template
                            "#" \n
                            "# " _ \n
                            "#" \n
                            "# Authors:" \n
                            "#   " user-full-name " <" user-mail-address ">" \n
                            "#" \n
                            \n))))))
