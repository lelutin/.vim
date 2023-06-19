# Cheat sheet for vim mappings

... cause there's so much damned shortcuts to remember

A note for passers-by (since this file will be public), I don't intend to add
much explanations in this repository since this is my own personal
configuration for Vim. The mappings noted here are the ones I think can be most
useful and for which I want to make an effort to remember. Also, the notes in
this file are in french and I don't intend to translate them for myself.

However, I'll be glad to answer your questions if you have some and I can
translate some parts if you want to know more, so don't hesitate to open
issues.

1. [Gestion de fenêtres et de tabs](#gestion-de-fenêtres-et-de-tabs)
2. [Mouvements du curseur](#mouvements-du-curseur)
3. [Folds](#folds)
4. [Modifier le texte](#modifier-le-texte)
5. [Toggle des options](#toggle-des-options)
6. [Débugger du code](#débugger-du-code)
7. [Références](#références)

Pour bootstrap la configuration de vim, il faut:

    cd; git clone git@github.com:lelutin/.vim.git
    mkdir ~/.vim/bundle
    vim -c "PlugInstall"
    # should already be committed to my dotfiles
    # ln -s ~/.vim/vintrc.yaml ~/.vintrc.yaml
    pip install vim-vint==0.4a3  # TODO this should be packaged in debian
    sudo gem install solargraph
    vim -c "CocInstall"

Note: mon caractère `<leader>` est configuré pour être `,` mais c'est moins
chiant d'écrire juste `,` dans les exemples

Pour information, coc.nvim installe ses extensions sous `~/.config/coc/` par
défaut.

## Gestion de fenêtres et de tabs

**n-mode**:

* `<c-w>v` :: séparer la fenêtre à la verticale sur le même buffer
* `<c-w>s` :: séparer la fenêtre à l'horizontale sur le même buffer
* `<c-w>n` :: séparer la fenêtre à l'horizontale avec un nouveau buffer
* `<c-w>$direction` :: se déplacer vers le tab dans cette direction là (où
  `$direction` est soit h,j,k,l soit les flèches)
* `<c-w>$maj_direction` :: déplacer le buffer actif vers la portion de l'écran
  qui correspond à la direction demandée où `$maj_direction` est un de H,J,K,L
  (e.g. `<c-w>H` utilise "la gauche" pour le buffer actif)
* `:Vex` :: ouvrir le file browser dans un split vertical
* `,<space>` :: ouvrir le file browser dans la fenêtre courante (p-e utiliser plus
    ça)
  * `:Ex` :: commande équivalente
* `:term [{cmd}]` :: ouvrir un terminal dans un nouveau split horizontal
  * si `{cmd}` est donné, roule la commande *au lieu* d'un terminal
  * avec l'option `++no-close` en plus, le terminal sera fermé quand la
    commande se termine (comportement par défaut pour un shell)
  * dans nvim le terminal s'ouvre dans un nouveau buffer mais dans la fenêtre
    actuelle par défaut. il faut utiliser `:sp | ter` pour l'ouvrir dans un
    nouveau split
* `:vert term` :: ouvrir un terminal dans un nouveau split vertical
  * fonctionne pas dans nvim. il faut plutôt utiliser: `:vsp | ter`
* `:term ++curwin` :: ouvrir un terminal dans la fenêtre courante

*vimrc*:

* `<c-w>V` :: séparer la fenêtre à la verticale avec un nouveau buffer

*vim-unimpaired*:

* `[f` :: ouvrir le fichier précédent en ordre alphabétique dans le même
  répertoire que le fichier courant
* `]f` :: ouvrir le prochain fichier en ordre alphabétique dans le même
  répertoire que le fichier courant

**t-mode**:

* `<c-w>N` :: dans un terminal, changer au mode "normal".

*vimrc*:

* `<c-w>n` :: même chose que `<c-w>N` mais sans avoir besoin de shift

## Mouvements du curseur

**n-mode**:

* `}` :: avancer d'un paragraphe (e.g. ligne vide)
* `{` :: reculer d'un paragraphe
* `]]` :: avancer d'une section (e.g. bloc de code ou bien section markdown)
* `[[` :: reculer d'une section
* `<c-o>` :: sauter à l'emplacement précédent du curseur (jump list)
* `<c-i>` :: sauter à l'emplacement suivant du curseur (jump list)
* `<c-b>` :: monter d'un écran (page précédente -- 'page back')
* `<c-f>` :: descendre d'un écran (page suivante -- 'page forward')
* `m$lettre` :: enregistrer l'emplacement du curseur dans la marque `$lettre`
* `'$lettre` :: déplacer le curseur au début de la ligne de la marque `$lettre`
* `` `$lettre`` :: déplacer le curseur à la position du marqueur `$lettre`
* `g;` :: sauter vers l'emplacement du dernier changement dans le buffer
* `gv` :: re-sélectionner la dernière sélection visuelle
* `/\%Vqqch` :: chercher `qqch` mais seulement à l'intérieur de la dernière
  sélection visuelle
* `gf` :: ouvrir en édition le nom de fichier sous le curseur, dans la même
  fenêtre (voir ctrl-o pour revenir en arrière)
* `<c-w>gf` :: ouvrir en édition le nom de fichier sous le curseur, dans un
  nouveau tab

*vimrc*:

* `gp` :: re-sélectionner le texte qui a été collé en dernier

*vim-unimpaired*:

* `[b` :: buffer précédent
* `]b` :: buffer suivant
* `[B` :: premier buffer
* `]B` :: dernier buffer
* `[l` :: "location" précédente (lprev)
* `]l` :: prochaine "location" (lprev)
* `[L` :: première "location" (lprev)
* `]L` :: dernière "location" (lprev)
* `[t` :: tag précédent
* `[T` :: prochain tag
* `]n` :: aller au conflit git ou au morceau de patch précédent
* `[n` :: aller au conflit git ou au morceau de patch suivant

*coc.nvim*:

* `[g` :: aller au diagnostique précédent (boucle au début)
* `[G` :: aller au diagnostique suivant (boucle à la fin)
* `gd` :: aller à la définition (ouvre une liste et un aperçu si c'est dans un
  autre fichier)
* `gr` :: lister les références d'une variable ou fonction
* TODO trouver ce que ça fait `gy`, et `gi`
* `K` :: afficher la documentation d'une fonction ou classe dans une popup

**i-mode**:

*vimrc*:

* `<c-a>` :: aller au début de la ligne
* `<c-e>` :: aller à la fin de la ligne
* `<c-h>` :: reculer d'un mot
* `<c-l>` :: avancer d'un mot
* `<c-x><c-e>`/`<c-x><c-y>` :: scroll vers en bas / vers en haut
* `<c-t>` :: swapper les deux caractères placés avant le curseur (comme `<c-t>` dans bash)

**pendant une recherche**:

* `<c-g>` :: prochain match
* `<c-G>` :: match précédent

**c-mode**:

* `<c-p>` :: commande précédente dans l'historique
  * si y'a du texte au début de la ligne de commande, ça ne cherche *pas* une
    commande avec le même préfixe dans l'historique contrairement à la flèche
    en haut. C'est dommage... Comment est-ce que je pourrais avoir cette
    fonctionnalité là sans avoir à me déplacer sur les flèches? :\
* `<c-n>` :: commande suivante dans l'historique
  * même commentaire que pour `<c-p>`

## Folds

* `zo` :: ouvrir le fold sous le curseur
* `zc` :: fermer le fold sous le curseur
* `za` :: toggle le fold sous le curseur
* `zM` :: fermer tous les folds récursivement
* `zR` :: ouvrir tous les folds récursivement

## Modifier le texte

**n-mode**:

* `dv0` :: Effacer le début de la ligne jusqu'au curseur, incluant le caractère
    sous le curseur (e.g. le modificateur `v` ajoute l'inclusion de la position
    sous le curseur)
* `z=` :: Remplacer le mot par une suggestion de dictionnaire
  * avec un compteur, e.g. `1z=`, automatiquement changer pour la Nième
    suggestion
* `zg` :: Marquer un mot comme "bon" (good) dans le dictionnaire courant
* `zw` :: Marquer un mot comme "mauvais" (wrong) dans le dictionnaire courant
* `zG` :: Comme `zg` mais pas permanent
* `zW` :: Comme `zw` mais pas permanent
* `zuw` / `zug` :: Undo de la commande `zw` / `zg`
* `zuW` / `zuG` :: Undo de la commande `zW` / `zG`
* `:<num>t.` :: Copie la ligne `<num>` sur la ligne en dessous du curseur
* `"0p` :: Coller le dernier contenu qui a été copié

*vimrc*:

* `,tw` :: Ouvrir un tab sur un fichier dans le même répertoire que le fichier
  courant
* `,ew` :: Editer un fichier dans la fenêtre actuelle, dans le même répertoire
* `,vw` :: Ouvrir un split vertical sur un fichier dans le même répertoire
  que le fichier courant
* `,ml` :: Ajouter un match qui highlight la ligne
* `,mc` :: Effacer (clear) les matches (donc les highlights). Note: ça enlève
  aussi les couleurs ajoutées par vim-indent-guides

*vim-surround*:

* `cs"'` :: changer un quote " en quote ' (toujours mieux d'utiliser les
  symboles fermant pour pas avoir d'espace)
  * remplacement custom en plus:
    * dans `embeddedpuppet`:
      * `-` -> `<%- \r -%>`
      * `%` -> `<% \r %>`
      * `=` -> `<%= \r %>`
* `cs${mouvement}}` :: entourer le mouvement du caractère spécial. (c'est comme
  `ysi${mouvement}}`)
* `ds"` :: retirer les quotes autour du curseur
* `dst` :: effacer un tag xml autour du curseur
* `ysW)` :: ajouter des parenthèses autour des caractères entre espaces
  * contrairement aux autres commandes, les caractères qui "entourent" peuvent
    être n'importe quoi, mais pour certains ça va matcher la paire au lieu du
    même des deux côtés (e.g. () {} [] et les tags xml)
* `yS${mouvement}B` :: place le texte dans le mouvement sur une nouvelle ligne
    indentée et entoure ça du caractère spécial demandé (B == block)
* `ys${mouvement}f${nom}` :: entoure le mouvement de parenthèses et le nom de fonction avant

*vim-commentary*:

* `gcc` :: toggle commentaire
* `gcu` :: décommenter la ligne et toutes les lignes de commentaire adjacentes
* `gc${mouvement}` :: toggle commentaire selon un mouvement (e.g. `gcB` mettre
  tout un bloc en commentaire)

*vim-speeddating*:

* `<c-a>` :: incrémenter une date
* `<c-x>` :: décrémenter une date

*vim-unimpaired*:

* `[e` :: échanger la ligne courante avec celle d'au dessus. Le curseur monte
  avec la ligne.
* `]e` :: échanger la ligne courante avec celle d'en dessous. Le curseur descend
  avec la ligne.
* `=p` :: colle après la ligne courante en réindentant le contenu collé
* `=P` :: colle avant la ligne courante en réindentant le contenu collé
* `[op` :: nouvelle ligne après la ligne courante en mode insertion avec
  'paste' activé. 'paste' est désactivé en sortant du mode insertion
* `[uu` :: URL encode
* `]uu` :: URL decode

*vim-tabular*:

* `,<tab>` :: aligner les flèches style ruby/puppet

*coc.vim*:

* `,rn` :: renommer une variable ou une classe (et toutes ses références)

*vim-markdown*:

* `:InsertNToc` :: Insérer une table des matières numérotée
* `:HeaderIncrease`/`:HeaderDecrease` :: Augmenter/Décrémenter tous les niveaux
  de headers du buffer

**i-mode**:

* `<c-w>` :: effacer un mot avant le curseur
* `<c-u>` :: effacer toute la ligne. Si la ligne est vide ça l'enlève
* `<c-i>` :: indenter (comme tab)
* `<c-j>` :: sauter à la ligne (comme enter)
* `<c-x>s` :: modifier le mot selon une suggestion de dictionnaire. Ensuite
  utiliser `<c-n>` et `<c-p>` pour utiliser une autre suggestion
* `<c-r>=` :: insérer le résultat d'un calcul

*vim-surround*:

* `<c-s>"` :: insérer des délimiteurs (e.g. "", (), {}, [])
* `<c-s><c-s>"` :: indente la ligne courante, insère le délimiteur, le curseur à
  la ligne d'après, indentée, et le délimiteur fermant sur la ligne suivante,
  indentée aussi.

*coc.vim*:

* `<c-space>` :: toggle la complétion de coc.vim
* `<cr>` :: quand la complétion est activée: accepter la sélection ou
  sélectionner le premier choix.

**v-mode**:

* `o` :: bouger le curseur de l'autre côté de la zone de sélection (e.g. en
  haut si le curseur est en bas, et inversement). On peut ensuite modifier la
  sélection à partir de l'autre côté (e.g. ajouter des lignes vers le haut)
* `/` :: déplacer la limite de la sélection vers le bas jusqu'au prochain match
  de la recherche
* `?` :: déplacer la limite de la sélection vers le haut jusqu'au prochain
  match de la recherche

*vim-speeddating*:

* `<c-a>` :: si la première ligne de la sélection contient un numéro et que les
  lignes en dessous sont vides (p-e des espaces seulement), créé une séquence
  numérique au même niveau d'indentation que le nombre sur la première ligne.
* `<c-x>` :: même chose que `<c-a>` mais en décrémentant.

## Toggle des options

**n-mode**:

* `:set spelllang=fr_fr` :: changer le dictionnaire au français

*vim-unimpaired*:

* `yon` :: numéros de lignes
* `yor` :: numéros relatifs de lignes
* `yos` :: spelling
* `yox` :: affiche la ligne et la colonne du curseur

## Débugger du code

*vimrc*:

* `,dpp` :: toggle un breakpoint
* `,dpc` :: toggle un breakpoint conditionnel (pas supporté par tous les
  adapteurs)
* `,dpf` :: ajouter un breakpoint de fonction (pas un toggle.. p-e y'aurait
  moyen de le faire?)
* `,dd` :: lancer une session de débuggage
* `,de` :: désactiver/fermer le débuggeur
* `,d_` :: redémarrer la run de débuggage avec les mêmes arguments
* `,dc` :: aller à la fenêtre de code
* `,dw` :: aller a la fenêtre de watches
* `,dt` :: aller à la fenêtre de terminal
* `,dv` :: aller à la fenêtre de variables
* `,ds` :: aller à la fenêtre de stack trace
* `,do` :: aller à la fenêtre d'output
* `,dpl` :: mettre à jour la location list avec la liste de breakpoints et
  afficher la location list.
* `,dl` :: (à droite, ) step into
* `,dh` :: (à gauche, ) step out
* `,dj` :: (en bas, ) step over
* `,dk` :: (en haut, ) continue
* `,d<space>` :: exécuter jusqu'au curseur
* `,dWa` :: ajouter un watch
* `,dWd` :: supprimer un watch

* `<F10>` :: afficher les groupes de syntaxe sous le curseur

## Références

* La meilleure référence c'est bien entendu `:help` 📚
* Quelques raccourcis intéressants dans: <https://github.com/VSCodeVim/Vim/blob/HEAD/ROADMAP.md>

