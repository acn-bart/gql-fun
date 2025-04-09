
# List groups

## Source
Data was acquired as:
https://graph.microsoft.com/v1.0/me/memberOf

## Browse
Can browse it like this:
```
cat mygroups.json |jq '.value[] | {grupa: .displayName, opis: .description}'
```

# List sections in OneNote

## Source
Data was acquired as:
https://graph.microsoft.com/v1.0/me/onenote/sections

This will list sections in all notebooks owned by you.

## Browse

It's comparable to groups, but to know the notebook name of section, there is additional nested field.
Since we don't want one specific notebook to be listed, we can use something more complicated like this:

```
cat mysections.json |jq '.value[] | select(.parentNotebook.displayName != "RestrictedBook") | {id: .id, grupa: .displayName, notatnik: .parentNotebook .displayName}'|lolcat
```
