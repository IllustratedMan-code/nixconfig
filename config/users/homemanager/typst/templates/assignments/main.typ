#import "@preview/titleize:0.1.0": titlecase
#let author(name, affiliation: none, email: none) = (name: name, affiliation: affiliation, email: email)

#let csvtable(csvdata) = {
  let data = csvdata.slice(1)
  table(
    columns: csvdata.first().len(),
    table.header(..csvdata.first()),
    ..csvdata.slice(1).flatten(),
    if csvdata.first().first() == "" {
      table.vline(x: 1)
    } else {
      table.vline(x: 1, stroke: none)
    },
  )
}
#let code(doc) = {
  let style-number(number) = text(gray)[#number]
  show raw.where(block: true): it => {
    let lang = none
    if it.lang != none {
      lang = [#upper(it.lang.first())#it.lang.slice(1)]
    }
    let codebox = block(
      outset: 0pt,
      stroke: black,
      radius: if lang != none {
        (
          top-left: 5pt,
          top-right: 0pt,
          bottom-right: 5pt,
          bottom-left: 5pt,
        )
      } else {
        5pt
      },

      inset: (x: 5pt, y: 5pt),
      grid(
        columns: 2,
        align: (right, left),
        gutter: 0.5em,
        ..it.lines.map(line => (style-number(line.number), line)).flatten()
      ),
    )
    let langbox = box(
      stroke: black,
      inset: 3pt,
      outset: 0pt,
      radius: (
        top-left: 5pt,
        top-right: 5pt,
        bottom-right: 0pt,
        bottom-left: 0pt,
      ),
      [
        #set text(8pt)
        #lang
      ],
    )
    set align(center)
    grid(
      columns: 1,
      align: (right),
      if lang != none {
        grid.header(langbox)
      },

      codebox,
    )
  }
  doc
}
#let conf(
  title: none,
  subtitle: none,
  date: none,
  authors: (author([David Lewis], email: "lewis3d7@mail.uc.edu"),),
  titlepage: true,
  doublespaced: false,
  doc,
) = {
  set text(top-edge: 0.7em, bottom-edge: -0.3em) if doublespaced == true
  set par(leading: 1em) if doublespaced == true
  if title != none {
    title = titlecase(title)
  }
  if subtitle != none {
    subtitle = titlecase(subtitle)
  }
  if date == none {
    date = datetime.today().display("[month repr:long] [day padding:none], [year]")
  }
  let style-number(number) = text(gray)[#number]

  show figure.where(kind: "code"): it => {
    it.supplement = [Code]
  }

  set bibliography(title: "References")

  show raw.where(block: true): it => {
    let lang = none
    if it.lang != none {
      lang = [#upper(it.lang.first())#it.lang.slice(1)]
    }
    let codebox = block(
      outset: 0pt,
      stroke: black,
      radius: if lang != none {
        (
          top-left: 5pt,
          top-right: 0pt,
          bottom-right: 5pt,
          bottom-left: 5pt,
        )
      } else {
        5pt
      },

      inset: (x: 5pt, y: 5pt),
      grid(
        columns: 2,
        align: (right, left),
        gutter: 0.5em,
        ..it.lines.map(line => (style-number(line.number), line)).flatten()
      ),
    )
    let langbox = box(
      stroke: black,
      inset: 3pt,
      outset: 0pt,
      radius: (
        top-left: 5pt,
        top-right: 5pt,
        bottom-right: 0pt,
        bottom-left: 0pt,
      ),
      [
        #set text(8pt)
        #lang
      ],
    )
    set align(center)
    grid(
      columns: 1,
      align: (right),
      if lang != none {
        grid.header(langbox)
      },

      codebox,
    )
  }
  set page(
    paper: "us-letter",
    header: context {
      if counter(page).get().first() > int(titlepage) and title != none [
        #title
        #h(1fr)
        #date

        #line(length: 100%)
      ]
    },
    footer: context [
      #line(length: 100%)

      #authors.map(author => [#author.name]).join(",")
      #h(1fr)
      #counter(page).display()
    ],
  )
  // quotes
  set quote(block: true, quotes: true, attribution: authors.first().name)
  show quote: quote => {
    set align(center)
    block(
      stroke: none,
      width: 80%,
      inset: 5pt,
      fill: rgb("#ffebcd"),
      radius: 5pt,
      {
        set align(left)
        quote
      },
    )
  }
  // tables
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: black)
    },
  )
  //
  //
  //figures
  show figure.caption: it => context {
    let caption_beginning = [#it.supplement #it.counter.display()#it.separator]
    let caption = [#caption_beginning#it.body]

    pad(
      left: 1cm,
      right: 2cm,
      align(
        left,
        par(hanging-indent: measure(caption_beginning).width + 0.2em, justify: true, caption),
      ),
    )
  }
  let r = rect(height: 2pt, fill: black, width: 100%)
  //

  //heading
  show heading.where(level: 1): it => block(
    align(
      center,
      grid(
        columns: (1fr, auto, 1fr),
        align: horizon,
        gutter: 5pt,
        r, [#it], r,
      ),
    ),
    breakable: false,
  )
  show heading.where(level: 2): it => block(
    align(
      left,
      grid(
        columns: (auto, 1fr),
        align: horizon,
        gutter: 5pt,
        [#it], rect(height: 1pt, fill: black, width: 100%),
      ),
    ),
    breakable: false,
  )
  show heading.where(level: 3): it => underline(it)
  {
    set align(center)
    if titlepage and title != none {
      [
        #text(17pt, weight: "bold", title) \
        #if subtitle != none [
          #text(15pt, weight: "semibold", subtitle) \
        ]
        #text(12pt, weight: "bold", date)
      ]


      let count = authors.len()
      let ncols = calc.min(count, 3)
      for i in range(calc.ceil(count / ncols)) {
        let end = calc.min((i + 1) * 3, count)
        let is-last = count == end
        let slice = authors.slice(i * ncols, end)
        grid(
          columns: (1fr,) * slice.len(),
          row-gutter: 2pt,
          ..slice.map(author => [
            #author.name \
            #if author.affiliation != none {
              [#author.affiliation \ ]
            }
            #if author.email != none {
              link("mailto:" + author.email)
            }
          ]),
        )
        if not is-last {
          v(16pt, weak: true)
        }
      }
      v(40pt, weak: true)
    }
  }
  doc
}
