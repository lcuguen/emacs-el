(defvar cw:erc-match:extra-nicks nil)

(defun erc-global-notify (match-type nick message)
  "Notify when a message is recieved."
  (unless (or
	   (string-match-p "^Server:" nick)
	   (string-match-p "^root" nick)
	   (string-match-p "^localhost$" nick)
	   (string= "ERC Keywords" (buffer-name)))
    ;;(message (format "MT: %S N: %S M: %S" match-type nick message))
    (unless (or
	     (eq match-type 'current-nick)
	     (member nick cw:erc-match:extra-nicks))
      (if (running-macosxp)
	  (growl (format "ERC: %s" nick) message)
	(notifications-notify
	 :title nick
	 :body message
	 :app-icon nil
	 :urgency 'low)))))

(add-hook 'erc-text-matched-hook 'erc-global-notify)
(remove-hook 'erc-text-matched-hook 'erc-log-matches)
