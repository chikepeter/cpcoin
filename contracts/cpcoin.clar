;; Title: cpcoin
;; Summary: A fungible token representing the cpcoin utility token.

;; Token metadata
(define-constant CONTRACT-OWNER tx-sender)
(define-constant TOKEN-NAME "cpcoin")
(define-constant TOKEN-SYMBOL u"CPC")
(define-constant TOKEN-DECIMALS u6)

;; Data variables
(define-data-var total-supply uint u0)

;; Data maps
(define-map balances
  { account: principal }
  { amount: uint })

;; Errors
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-BALANCE (err u101))
(define-constant ERR-INSUFFICIENT-ALLOWANCE (err u102))

;; Internal helpers
(define-private (is-owner (sender principal))
  (is-eq sender CONTRACT-OWNER))

(define-private (get-balance (who principal))
  (default-to u0 (get amount (map-get? balances { account: who }))))

(define-private (set-balance (who principal) (amount uint))
  (map-set balances { account: who } { amount: amount }))

;; Public functions

(define-public (mint (recipient principal) (amount uint))
  (begin
    (if (not (is-owner tx-sender))
        ERR-NOT-AUTHORIZED
        (begin
          (set-balance recipient (+ (get-balance recipient) amount))
          (var-set total-supply (+ (var-get total-supply) amount))
          (ok true)))))

(define-public (transfer (recipient principal) (amount uint))
  (let ((sender tx-sender)
        (sender-balance (get-balance tx-sender)))
    (if (< sender-balance amount)
        ERR-INSUFFICIENT-BALANCE
        (begin
          (set-balance sender (- sender-balance amount))
          (set-balance recipient (+ (get-balance recipient) amount))
          (ok true)))))

;; Read-only functions

(define-read-only (get-total-supply)
  (var-get total-supply))

(define-read-only (get-balance-of (who principal))
  (get-balance who))
