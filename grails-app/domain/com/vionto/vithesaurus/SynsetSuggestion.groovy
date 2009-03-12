/**
 * vithesaurus - web-based thesaurus management tool
 * Copyright (C) 2009 vionto GmbH, www.vionto.com
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */ 
package com.vionto.vithesaurus;

/**
 * A concept candidate, suggested by the automatic import.
 */
class SynsetSuggestion implements Comparable {

    String term
    /**
     * Number of ocurrences of this term.
     */
    int termCount
    
    static mapping = {
        id generator:'sequence', params:[sequence:'synset_suggestion_seq']
    }

    SynsetSuggestion() {
    }

    /**
     * A stable sort order: order by term
     */
    int compareTo(Object other) {
        SynsetSuggestion otherSugg = (SynsetSuggestion)other
        return otherSugg.term.compareToIgnoreCase(otherSugg.term)
    }

    String toString() {
        return "${term}@${termCount}"
    }
}
