(in-package :stumpwm)

(defparameter *mode-line-shell* (uiop:launch-program "bash" :input :stream :output :stream))

(defun async-run (command)
  (write-line command (uiop:process-info-input *mode-line-shell*))
  (force-output (uiop:process-info-input *mode-line-shell*))
  (let* ((output-string (read-line (uiop:process-info-output *mode-line-shell*)))
         (stream (uiop:process-info-output *mode-line-shell*)))
    (if (listen stream)
        (loop while (listen stream)
              do (setf output-string (str:concat output-string
                                                 (format nil "~%")
                                                 (read-line stream)))))
    output-string))
