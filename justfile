# Recettes appelées par le moteur de la méthode ([commands] de delivery.toml).
# Dépôt de spec : pas d'application ; « serve » lance l'application vide fournie par la méthode,
# contre laquelle toute la suite d'IHM doit être rouge. La CI ne joue que « check ».

# Contrôle de la spec (schéma, neutralité, un test par critère) ; jugé sur son code de sortie.
check:
    .delivery/deliveryctl spec lint

# Un test ciblé de la suite d'IHM ; selector : fichier ou titre de test Playwright.
test selector:
    cd spec/acceptance && npx playwright test {{selector}}

# Tests d'IHM de spec/acceptance ; grep = @<story de spec>, vide = suite complète. Playwright
# lance lui-même l'application vide (APP_CMD) sur le port de la story, 3999 par défaut.
acceptance grep='':
    cd spec/acceptance && BASE_URL="http://localhost:${DELIVERY_PORT:-3999}" APP_CMD="just serve ${DELIVERY_PORT:-3999}" npx playwright test --grep '{{grep}}'

# L'application vide, sur le port donné.
serve port:
    PORT={{port}} node spec/acceptance/fixtures/empty-app/server.mjs
